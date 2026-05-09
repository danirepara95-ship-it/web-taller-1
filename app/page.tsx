import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Users, Laptop, ClipboardList, Package, ShieldCheck, Sparkles, DollarSign } from "lucide-react"

const stats = [
  {
    title: "Clientes",
    value: "1,248",
    icon: Users,
    description: "Registros activos",
    bg: "bg-blue-100",
    color: "text-blue-600",
  },
  {
    title: "Equipos en reparación",
    value: "37",
    icon: Laptop,
    description: "En proceso técnico",
    bg: "bg-amber-100",
    color: "text-amber-600",
  },
  {
    title: "Órdenes activas",
    value: "52",
    icon: ClipboardList,
    description: "Seguimiento de servicios",
    bg: "bg-violet-100",
    color: "text-violet-600",
  },
  {
    title: "Inventario",
    value: "326",
    icon: Package,
    description: "Repuestos y consumibles",
    bg: "bg-slate-100",
    color: "text-slate-700",
  },
]

export default function HomePage() {
  return (
    <main className="min-h-screen bg-slate-50 px-6 py-10 sm:px-10">
      <section className="mx-auto max-w-6xl">
        <div className="rounded-3xl border border-slate-200 bg-white p-8 shadow-sm">
          <div className="grid gap-10 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
            <div className="space-y-6">
              <div className="inline-flex items-center gap-2 rounded-full bg-blue-100 px-4 py-2 text-sm font-medium text-blue-800">
                <Sparkles className="h-4 w-4" />
                Gestión integral para tu taller
              </div>
              <div>
                <h1 className="text-4xl font-bold tracking-tight text-slate-900 sm:text-5xl">
                  Sistema administrativo para talleres de reparación de computadoras y laptops
                </h1>
                <p className="mt-4 max-w-2xl text-lg leading-8 text-slate-600">
                  Controla clientes, equipos, órdenes, inventario, compras y reportes con una interfaz profesional y totalmente responsiva.
                </p>
              </div>
              <div className="flex flex-col gap-4 sm:flex-row">
                <Button asChild>
                  <Link href="/login">Iniciar Sesión</Link>
                </Button>
                <Button variant="outline" asChild>
                  <Link href="/dashboard">Ver Dashboard</Link>
                </Button>
              </div>
            </div>
            <div className="grid gap-4 sm:grid-cols-2">
              {stats.map((item) => {
                const Icon = item.icon
                return (
                  <Card key={item.title} className="overflow-hidden bg-slate-50">
                    <CardHeader className="flex items-start justify-between gap-4 p-5">
                      <div className="space-y-2">
                        <CardTitle className="text-sm font-semibold text-slate-900">{item.title}</CardTitle>
                        <CardDescription className="text-sm text-slate-600">{item.description}</CardDescription>
                      </div>
                      <div className={`rounded-2xl p-3 ${item.bg}`}>
                        <Icon className={`h-5 w-5 ${item.color}`} />
                      </div>
                    </CardHeader>
                    <CardContent className="px-5 pb-5 pt-0">
                      <div className="text-3xl font-bold text-slate-900">{item.value}</div>
                    </CardContent>
                  </Card>
                )
              })}
            </div>
          </div>
        </div>
      </section>
      <section className="mx-auto mt-10 max-w-6xl">
        <div className="grid gap-6 lg:grid-cols-3">
          <Card className="border-blue-900/10 bg-blue-50">
            <CardContent>
              <div className="flex items-center justify-between gap-4">
                <div>
                  <h2 className="text-xl font-semibold text-slate-900">Organiza tu taller</h2>
                  <p className="mt-2 text-sm text-slate-600">Visualiza órdenes, clientes y tareas en un solo lugar.</p>
                </div>
                <ShieldCheck className="h-6 w-6 text-blue-700" />
              </div>
            </CardContent>
          </Card>
          <Card className="border-amber-900/10 bg-amber-50">
            <CardContent>
              <div className="flex items-center justify-between gap-4">
                <div>
                  <h2 className="text-xl font-semibold text-slate-900">Control de inventario</h2>
                  <p className="mt-2 text-sm text-slate-600">Detecta repuestos bajos y gestiona compras automáticamente.</p>
                </div>
                <Package className="h-6 w-6 text-amber-700" />
              </div>
            </CardContent>
          </Card>
          <Card className="border-emerald-900/10 bg-emerald-50">
            <CardContent>
              <div className="flex items-center justify-between gap-4">
                <div>
                  <h2 className="text-xl font-semibold text-slate-900">Reportes inteligentes</h2>
                  <p className="mt-2 text-sm text-slate-600">Obtén métricas de ingresos, utilidad y productividad por técnico.</p>
                </div>
                <DollarSign className="h-6 w-6 text-emerald-700" />
              </div>
            </CardContent>
          </Card>
        </div>
      </section>
    </main>
  )
}