'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { cn } from '@/lib/utils'
import {
  LayoutDashboard,
  Users,
  Laptop,
  ClipboardList,
  Package,
  ShoppingCart,
  FileText,
  CreditCard,
  TrendingUp,
  Settings,
  LogOut
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { createClient } from '@/lib/supabase'
import { useRouter } from 'next/navigation'

const menuItems = [
  { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { href: '/dashboard/clients', label: 'Clientes', icon: Users },
  { href: '/dashboard/equipos', label: 'Equipos', icon: Laptop },
  { href: '/dashboard/ordenes', label: 'Órdenes', icon: ClipboardList },
  { href: '/dashboard/inventario', label: 'Inventario', icon: Package },
  { href: '/dashboard/compras', label: 'Compras', icon: ShoppingCart },
  { href: '/dashboard/presupuestos', label: 'Presupuestos', icon: FileText },
  { href: '/dashboard/pagos', label: 'Pagos', icon: CreditCard },
  { href: '/dashboard/reportes', label: 'Reportes', icon: TrendingUp },
  { href: '/dashboard/configuracion', label: 'Configuración', icon: Settings },
]

export function Sidebar() {
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  const handleLogout = async () => {
    await supabase.auth.signOut()
    router.push('/login')
  }

  return (
    <div className="w-64 bg-blue-900 text-white flex flex-col">
      <div className="p-6">
        <h1 className="text-xl font-bold">Taller Técnico</h1>
      </div>
      <nav className="flex-1 px-4">
        <ul className="space-y-2">
          {menuItems.map((item) => {
            const Icon = item.icon
            return (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className={cn(
                    'flex items-center px-4 py-2 rounded-lg hover:bg-blue-800 transition-colors',
                    pathname === item.href && 'bg-blue-800'
                  )}
                >
                  <Icon className="w-5 h-5 mr-3" />
                  {item.label}
                </Link>
              </li>
            )
          })}
        </ul>
      </nav>
      <div className="p-4">
        <Button
          onClick={handleLogout}
          variant="ghost"
          className="w-full justify-start text-white hover:bg-blue-800"
        >
          <LogOut className="w-5 h-5 mr-3" />
          Cerrar Sesión
        </Button>
      </div>
    </div>
  )
}