CREATE TABLE patients(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE
);

CREATE TABLE medical_histories(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(100),

  CONSTRAINT fk_patient_id
    FOREIGN KEY(patient_id)
      REFERENCES patients(id)
);


CREATE TABLE treatments(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100),
  name VARCHAR(100)
);

CREATE TABLE medical_treatments(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  medic_history_id INT,
  treatments_id INT,

  CONSTRAINT fk_medic_history_id
    FOREIGN KEY(medic_history_id)
      REFERENCES medical_histories(id),

  CONSTRAINT fk_treatments_id
    FOREIGN KEY(treatments_id)
      REFERENCES treatments(id)
);

CREATE TABLE invoices(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  total_amount DEC(15, 2),
  generated_at TIMESTAMP,
  played_at TIMESTAMP,
  medical_history_id INT
);

CREATE TABLE invoice_items( 
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  unit_price DEC(15, 2), 
  quantity INT, 
  total_price DEC(15, 2), 
  invoice_id INT, 
  treatment_id INT, 
  CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id), 
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id) 
 ); 

