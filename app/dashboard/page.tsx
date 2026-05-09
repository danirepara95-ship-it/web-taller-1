import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Laptop, Users, ClipboardList, AlertTriangle } from 'lucide-react'

export default function DashboardPage() {
  // Mock data - in real app, fetch from Supabase
  const stats = {
    equiposReparacion: 12,
    equiposListos: 5,
    equiposVencidos: 2,
    ingresosDiarios: 150000,
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Dashboard</h1>
        <p className="text-gray-600">Resumen general del taller</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Equipos en Reparación</CardTitle>
            <Laptop className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.equiposReparacion}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Listos para Entrega</CardTitle>
            <ClipboardList className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">{stats.equiposListos}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Equipos Vencidos</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-red-600">{stats.equiposVencidos}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Ingresos Diarios</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${stats.ingresosDiarios.toLocaleString()}</div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Órdenes Recientes</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {/* Mock orders */}
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium">Orden #001</p>
                  <p className="text-sm text-gray-600">Laptop Dell Inspiron</p>
                </div>
                <Badge variant="secondary">En diagnóstico</Badge>
              </div>
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium">Orden #002</p>
                  <p className="text-sm text-gray-600">PC Gamer</p>
                </div>
                <Badge variant="destructive">Urgente</Badge>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Inventario Bajo</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <span>Disco duro 1TB</span>
                <Badge variant="outline">Stock: 2</Badge>
              </div>
              <div className="flex items-center justify-between">
                <span>RAM 8GB</span>
                <Badge variant="outline">Stock: 1</Badge>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}