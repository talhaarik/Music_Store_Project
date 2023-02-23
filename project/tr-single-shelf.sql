CREATE OR REPLACE TRIGGER single_shelf
  BEFORE INSERT ON single_shelf
  FOR EACH ROW
  declare
  capacity_tr NUMBER;
BEGIN
    select shelf_capacity into capacity_tr from shelf where shelf_id = :new.shelf_id;
    IF capacity_tr > 0 THEN
        update shelf set shelf_capacity = (select shelf_capacity from shelf where shelf_id = :new.shelf_id) - 1 where shelf_id = :new.shelf_id; 
    else RAISE_APPLICATION_ERROR( -20001, 
                             'stock must be available' );
    END IF;
END;

