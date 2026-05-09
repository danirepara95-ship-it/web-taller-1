-- Seed data for demo

-- Insert demo users (these need to be created in Supabase Auth first)
-- Passwords should be set in Supabase Auth

-- Profiles
INSERT INTO profiles (id, role, full_name, phone) VALUES
('admin-uuid', 'admin', 'Administrador', '+1234567890'),
('tecnico-uuid', 'tecnico', 'Técnico Principal', '+1234567891'),
('recepcion-uuid', 'recepcion', 'Recepcionista', '+1234567892');

-- Clients
INSERT INTO clients (name, document, phone, email, address) VALUES
('Juan Pérez', '12345678', '+1234567890', 'juan@email.com', 'Calle 123, Ciudad'),
('María García', '87654321', '+1234567891', 'maria@email.com', 'Avenida 456, Ciudad'),
('Carlos López', '11223344', '+1234567892', 'carlos@email.com', 'Plaza 789, Ciudad');

-- Equipos
INSERT INTO equipos (client_id, type, brand, model, serial_number, accessories, physical_state, observations) VALUES
((SELECT id FROM clients WHERE document = '12345678'), 'laptop', 'Dell', 'Inspiron 15', 'SN123456', 'Cargador, Mouse', 'Buen estado', 'Pantalla con rayón pequeño'),
((SELECT id FROM clients WHERE document = '87654321'), 'pc', 'HP', 'Pavilion', 'SN654321', 'Teclado, Mouse', 'Estado regular', 'Requiere limpieza'),
((SELECT id FROM clients WHERE document = '11223344'), 'laptop', 'Lenovo', 'ThinkPad', 'SN789012', 'Cargador', 'Excelente estado', 'Batería nueva');

-- Ordenes
INSERT INTO ordenes (client_id, equipo_id, order_number, ingreso_date, diagnosis, status, priority, tecnico_id, estimated_cost, promised_date) VALUES
((SELECT id FROM clients WHERE document = '12345678'), (SELECT id FROM equipos WHERE serial_number = 'SN123456'), 1, CURRENT_DATE, 'Problema de arranque', 'en_diagnostico', 'media', 'tecnico-uuid', 50000, CURRENT_DATE + 3),
((SELECT id FROM clients WHERE document = '87654321'), (SELECT id FROM equipos WHERE serial_number = 'SN654321'), 2, CURRENT_DATE - 1, 'Sobrecalentamiento', 'en_reparacion', 'alta', 'tecnico-uuid', 75000, CURRENT_DATE + 2),
((SELECT id FROM clients WHERE document = '11223344'), (SELECT id FROM equipos WHERE serial_number = 'SN789012'), 3, CURRENT_DATE - 2, 'Actualización de software', 'reparado', 'baja', 'tecnico-uuid', 25000, CURRENT_DATE - 1);

-- Inventario
INSERT INTO inventario (sku, name, stock, min_stock, cost, price, supplier) VALUES
('HD001', 'Disco duro 1TB', 5, 2, 30000, 45000, 'Proveedor A'),
('RAM008', 'RAM 8GB DDR4', 10, 3, 25000, 40000, 'Proveedor B'),
('SSD256', 'SSD 256GB', 8, 2, 50000, 75000, 'Proveedor A'),
('BATERIA', 'Batería laptop genérica', 15, 5, 20000, 35000, 'Proveedor C');

-- Tareas
INSERT INTO tareas (orden_id, description, assigned_to, due_date, status) VALUES
((SELECT id FROM ordenes WHERE order_number = 1), 'Diagnosticar problema de arranque', 'tecnico-uuid', CURRENT_DATE + 1, 'pendiente'),
((SELECT id FROM ordenes WHERE order_number = 2), 'Reemplazar ventilador', 'tecnico-uuid', CURRENT_DATE + 2, 'en_progreso'),
((SELECT id FROM ordenes WHERE order_number = 3), 'Instalar actualizaciones', 'tecnico-uuid', CURRENT_DATE, 'completada');

-- Pagos
INSERT INTO pagos (orden_id, amount, method, date) VALUES
((SELECT id FROM ordenes WHERE order_number = 3), 25000, 'efectivo', CURRENT_DATE - 1);

-- Gastos
INSERT INTO gastos (description, amount, date, category) VALUES
('Compra de repuestos', 150000, CURRENT_DATE - 7, 'Inventario'),
('Pago de servicios', 50000, CURRENT_DATE - 3, 'Operativos');