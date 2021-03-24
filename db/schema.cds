namespace zfr.cap.bookshop;

using { Currency, managed } from '@sap/cds/common';

entity Books:managed{
    key ID : Integer;
    title : localized String(111);
    descr : localized String(1111);
    author: Association to Authors;
    stock: Integer;
    price: Decimal(9,2);
    currency: Currency;
}

entity Authors:managed{
    key ID: Integer;
    name : String(1111);
    books: Association to many Books on books.author = $self;
}

entity Order:managed{ 
    key ID: UUID;
    OrderNo: String @title:'Order Number'; //>Readable key
    Items : Composition of many OrderItems on Items.parent = $self;
}

entity OrderItems:managed{
    key ID:UUID;
    parent: Association to Order;
    book: Association to Books;
    amount: Integer;
}
