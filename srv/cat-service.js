module.exports = (srv)=>{
    const {Books} = cds.entities;

    srv.after( 'READ', 'Books', (each) => {
        if(each.stock > 111) each.title += '--- 11% discount!';
    })

    srv.before('CREATE','Orders', async (req) => {

        const tx = cds.transaction(req); 
        const order = req.data;
        if(order.Items){
            const affectedRows = await tx.run( order.Items.map( item => 
                UPDATE(Books).where({ID:item.book_ID})
                .and('stock >=', item.amount)
                .set('stock -=', item.amount)
                )); 
            if( affectedRows.some(row => !row )) req.error(409,'Sold out, Sorry!'); 
        }


    });
}