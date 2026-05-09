# Taller de Servicio Técnico

Aplicación web profesional para la gestión de un taller de servicio técnico de computadores y laptops.

## Tecnologías

- **Frontend**: Next.js 15 con App Router
- **Backend**: Supabase (PostgreSQL)
- **Autenticación**: Supabase Auth
- **UI**: shadcn/ui con Tailwind CSS
- **Hosting**: Vercel

## Instalación

1. Clona el repositorio
2. Instala las dependencias:
   ```bash
   npm install
   ```

3. Configura las variables de entorno:
   Crea un archivo `.env.local` con:
   ```
   NEXT_PUBLIC_SUPABASE_URL=tu_supabase_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_supabase_anon_key
   ```

4. Configura Supabase:
   - Crea un proyecto en [Supabase](https://supabase.com)
   - Ejecuta el script SQL en `supabase/migrations/001_initial_schema.sql`
   - Configura la autenticación

5. Ejecuta el servidor de desarrollo:
   ```bash
   npm run dev
   ```

## Usuarios de Demo

- **Admin**: admin@taller.com
- **Técnico**: tecnico@taller.com
- **Recepción**: recepcion@taller.com

## Despliegue en Vercel

1. Conecta tu repositorio a Vercel
2. Configura las variables de entorno en Vercel
3. Despliega

## Funcionalidades

- Dashboard con estadísticas
- Gestión de clientes
- Registro de equipos
- Órdenes de servicio
- Seguimiento de tareas
- Inventario
- Compras y presupuestos
- Facturación
- Reportes
- Portal del cliente

## Estructura del Proyecto

```
app/
├── dashboard/          # Páginas del dashboard
├── login/             # Página de login
components/            # Componentes reutilizables
lib/                   # Utilidades y configuración
supabase/              # Migraciones de base de datos
```

## Licencia

Este proyecto es de código abierto.
# web-taller-1
