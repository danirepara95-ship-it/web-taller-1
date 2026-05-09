import {
  Users,
  Laptop,
  Wrench,
  Package,
  DollarSign,
  AlertTriangle,
  CheckCircle,
  Clock,
} from "lucide-react";

const stats = [
  {
    title: "Clientes",
    value: "1,248",
    icon: Users,
    color: "text-blue-600",
    bg: "bg-blue-100",
  },
  {
    title: "Equipos en Reparación",
    value: "37",
    icon: Laptop,
    color: "text-amber-600",
    bg: "bg-amber-100",
  },
  {
    title: "Órdenes Activas",
    value: "52",
    icon: Wrench,
    color: "text-indigo-600",
    bg: "bg-indigo-100",
  },
  {
    title: "Inventario",
    value: "326",
    icon: Package,
    color: "text-purple-600",
    bg: "bg-purple-100",
  },
  {
    title: "Ingresos del Mes",
    value: "$8.450.000",
    icon: DollarSign,
    color: "text-green-600",
    bg: "bg-green-100",
  },
  {
    title: "Stock Bajo",
    value: "12",
    icon: AlertTriangle,
    color: "text-red-600",
    bg: "bg-red-100",
  },
];

const recentOrders = [
  {
    code: "OS-2026-001",
    client: "Carlos Pérez",
    device: "HP Pavilion 15",
    status: "En diagnóstico",
  },
  {
    code: "OS-2026-002",
    client: "María Gómez",
    device: "Lenovo ThinkPad",
    status: "En diagnóstico",
  },
];
