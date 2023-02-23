CREATE OR REPLACE TRIGGER sell_single
  BEFORE INSERT ON single_sale
  FOR EACH ROW
  declare
  stock_tr NUMBER;
BEGIN
    select stock into stock_tr from singles where single_id = :new.single_id;
    IF stock_tr > 0 THEN
        update singles set stock = (select stock from singles where single_id = :new.single_id) - 1 where single_id = :new.single_id; 
    else RAISE_APPLICATION_ERROR( -20001, 
                             'stock must be available' );
    END IF;
END;