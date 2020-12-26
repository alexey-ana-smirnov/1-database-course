CREATE TRIGGER check_duplicate_registration
BEFORE INSERT ON registration
FOR EACH ROW
BEGIN
  IF (EXISTS(SELECT 1 FROM registration WHERE departure_id = NEW.departure_id and passport=new.passport)) THEN
    SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT failed due to duplicate registration on the same flight';
  END IF;
END