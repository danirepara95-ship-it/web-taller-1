-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE user_role AS ENUM ('admin', 'tecnico', 'recepcion');
CREATE TYPE equipo_type AS ENUM ('laptop', 'pc', 'impresora', 'consola', 'otro');
CREATE TYPE orden_status AS ENUM ('recibido', 'en_diagnostico', 'esperando_aprobacion', 'en_reparacion', 'esperando_repuesto', 'reparado', 'listo_entrega', 'entregado', 'cancelado');
CREATE TYPE orden_priority AS ENUM ('baja', 'media', 'alta', 'urgente');
CREATE TYPE tarea_status AS ENUM ('pendiente', 'en_progreso', 'completada');
CREATE TYPE pago_method AS ENUM ('efectivo', 'tarjeta', 'transferencia', 'otro');

-- Profiles table (extends auth.users)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  role user_role NOT NULL DEFAULT 'recepcion',
  full_name TEXT,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Clients table
CREATE TABLE clients (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  document TEXT UNIQUE,
  phone TEXT,
  email TEXT,
  address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Equipos table
CREATE TABLE equipos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  type equipo_type NOT NULL,
  brand TEXT NOT NULL,
  model TEXT NOT NULL,
  serial_number TEXT,
  accessories TEXT,
  physical_state TEXT,
  password TEXT,
  observations TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Ordenes table
CREATE TABLE ordenes (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  equipo_id UUID REFERENCES equipos(id) ON DELETE CASCADE,
  order_number SERIAL UNIQUE NOT NULL,
  ingreso_date DATE NOT NULL DEFAULT CURRENT_DATE,
  diagnosis TEXT,
  status orden_status NOT NULL DEFAULT 'recibido',
  priority orden_priority NOT NULL DEFAULT 'media',
  tecnico_id UUID REFERENCES profiles(id),
  estimated_cost DECIMAL(10,2),
  final_cost DECIMAL(10,2),
  promised_date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tareas table
CREATE TABLE tareas (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  orden_id UUID REFERENCES ordenes(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  assigned_to UUID REFERENCES profiles(id),
  due_date DATE,
  status tarea_status NOT NULL DEFAULT 'pendiente',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Inventario table
CREATE TABLE inventario (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  sku TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  stock INTEGER NOT NULL DEFAULT 0,
  min_stock INTEGER NOT NULL DEFAULT 0,
  cost DECIMAL(10,2),
  price DECIMAL(10,2),
  supplier TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Compras table
CREATE TABLE compras (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  supplier TEXT NOT NULL,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Compra items table
CREATE TABLE compra_items (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  compra_id UUID REFERENCES compras(id) ON DELETE CASCADE,
  inventario_id UUID REFERENCES inventario(id) ON DELETE CASCADE,
  quantity INTEGER NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  total DECIMAL(10,2) NOT NULL
);

-- Presupuestos table
CREATE TABLE presupuestos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  items JSONB NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  status TEXT NOT NULL DEFAULT 'pendiente',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pagos table
CREATE TABLE pagos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  orden_id UUID REFERENCES ordenes(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  method pago_method NOT NULL,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Gastos table
CREATE TABLE gastos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  description TEXT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  category TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notifications table
CREATE TABLE notifications (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  orden_id UUID REFERENCES ordenes(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  message TEXT NOT NULL,
  sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Files table for attachments
CREATE TABLE files (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  orden_id UUID REFERENCES ordenes(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  type TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Row Level Security Policies

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipos ENABLE ROW LEVEL SECURITY;
ALTER TABLE ordenes ENABLE ROW LEVEL SECURITY;
ALTER TABLE tareas ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE compras ENABLE ROW LEVEL SECURITY;
ALTER TABLE compra_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE presupuestos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagos ENABLE ROW LEVEL SECURITY;
ALTER TABLE gastos ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE files ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view their own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles" ON profiles
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Clients policies
CREATE POLICY "Authenticated users can view clients" ON clients
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Authenticated users can insert clients" ON clients
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Authenticated users can update clients" ON clients
  FOR UPDATE TO authenticated USING (true);

-- Similar policies for other tables, adjusted for roles

-- For brevity, basic policies; in production, refine based on roles

-- Equipos policies
CREATE POLICY "Authenticated users can CRUD equipos" ON equipos
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Ordenes policies
CREATE POLICY "Authenticated users can CRUD ordenes" ON ordenes
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- And so on for other tables...

-- Indexes for performance
CREATE INDEX idx_profiles_role ON profiles(role);
CREATE INDEX idx_clients_document ON clients(document);
CREATE INDEX idx_equipos_client_id ON equipos(client_id);
CREATE INDEX idx_ordenes_client_id ON ordenes(client_id);
CREATE INDEX idx_ordenes_equipo_id ON ordenes(equipo_id);
CREATE INDEX idx_ordenes_status ON ordenes(status);
CREATE INDEX idx_ordenes_order_number ON ordenes(order_number);
CREATE INDEX idx_tareas_orden_id ON tareas(orden_id);
CREATE INDEX idx_inventario_sku ON inventario(sku);
CREATE INDEX idx_pagos_orden_id ON pagos(orden_id);

-- Triggers for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_clients_updated_at BEFORE UPDATE ON clients
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_equipos_updated_at BEFORE UPDATE ON equipos
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ordenes_updated_at BEFORE UPDATE ON ordenes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tareas_updated_at BEFORE UPDATE ON tareas
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_inventario_updated_at BEFORE UPDATE ON inventario
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_presupuestos_updated_at BEFORE UPDATE ON presupuestos
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();