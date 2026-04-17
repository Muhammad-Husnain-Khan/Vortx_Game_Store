const { getPool, sql } = require('../config/db');

exports.placeOrder = async (req, res) => {
  try {
    const { paymentMethod, billingAddress, items } = req.body;
    
    if (!items || items.length === 0) {
      return res.status(400).json({ error: 'No items in order.' });
    }

    const pool = getPool();
    const userID = req.user.UserID;

    for (const item of items) {
      const check = await pool.request()
        .input('UserID', sql.Int, userID)
        .input('GameID', sql.Int, item.gameId)
        .execute('sp_CheckOwnership');
      if (check.recordset[0].Owned > 0) {
        return res.status(400).json({ error: `You already own game ID ${item.gameId}.` });
      }
    }

    const totalAmount = items.reduce((sum, item) => sum + (item.price * (item.quantity || 1)), 0);
    const transactionID = 'TXN-' + Date.now() + '-' + Math.random().toString(36).substr(2, 6).toUpperCase();

    const orderResult = await pool.request()
      .input('UserID', sql.Int, userID)
      .input('TotalAmount', sql.Decimal(10, 2), totalAmount)
      .input('PaymentMethod', sql.VarChar(50), paymentMethod)
      .input('PaymentStatus', sql.VarChar(20), 'Completed')
      .input('TransactionID', sql.VarChar(100), transactionID)
      .input('BillingAddress', sql.VarChar(sql.MAX), billingAddress)
      .execute('sp_PlaceOrder');

    const orderID = orderResult.recordset[0].NewOrderID;

    for (const item of items) {
      await pool.request()
        .input('OrderID', sql.Int, orderID)
        .input('GameID', sql.Int, item.gameId)
        .input('PurchasePrice', sql.Decimal(10, 2), item.price)
        .input('Quantity', sql.Int, item.quantity || 1)
        .execute('sp_AddOrderDetail');

      await pool.request()
        .input('UserID', sql.Int, userID)
        .input('GameID', sql.Int, item.gameId)
        .input('OrderID', sql.Int, orderID)
        .execute('sp_AddToLibrary');

      await pool.request()
        .query(`UPDATE Games SET TotalSales = TotalSales + ${item.quantity || 1} WHERE GameID = ${item.gameId}`);
    }

    res.status(201).json({ 
      message: 'Order placed successfully!',
      orderId: orderID,
      transactionId: transactionID
    });
  } catch (error) {
    console.error('Place order error:', error.message);
    res.status(500).json({ error: 'Failed to place order.' });
  }
};

exports.getOrderHistory = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .execute('sp_GetUserPurchaseHistory');
    res.json({ orders: result.recordset });
  } catch (error) {
    console.error('Order history error:', error.message);
    res.status(500).json({ error: 'Failed to fetch order history.' });
  }
};
