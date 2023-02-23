CREATE OR REPLACE TRIGGER sell_album
  BEFORE INSERT ON album_sale
  FOR EACH ROW
  declare
  stock_tr NUMBER;
BEGIN
    select stock into stock_tr from album where album_id = :new.album_id;
    IF stock_tr > 0 THEN
        update album set stock = (select stock from album where album_id = :new.album_id) - 1 where album_id = :new.album_id; 
    else RAISE_APPLICATION_ERROR( -20001, 
                             'stock must be available' );
    END IF;
END;