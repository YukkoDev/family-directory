# Directorio familiar (Vercel + Supabase) — sin emails

## 1. Supabase (gratis)
1. Crea un proyecto en https://supabase.com
2. **Authentication → Providers → Email: desactiva "Confirm email"** (así no se envía ningún correo).
   En Authentication → Sign In / Providers deja los registros (sign ups) activados.
3. SQL Editor → abre `schema.sql`, cambia CAMBIA-ESTE-CODIGO por vuestro código familiar → Run.
4. Project Settings → API: copia **Project URL** y la clave **anon public** y pégalas al final de `index.html`.

## 2. Vercel
Sube la carpeta a GitHub e impórtala en https://vercel.com (Add New → Project → Deploy),
o ejecuta `npx vercel --prod` dentro de la carpeta. Es una web estática, no requiere configuración.

## 3. Uso
Cada persona abre la web → "Crear cuenta" con email, contraseña y el código familiar → rellena su ficha.
Después entra solo con email y contraseña.

## Notas
- Si alguien olvida la contraseña: Supabase → Authentication → Users → ese usuario → cambiar contraseña (o borrarlo y que se registre de nuevo).
- El email no se verifica (no se envía nada): cualquiera con el código puede registrarse. Para cambiar el código, cambia el texto en la función `es_familia()` y los antiguos pierden el acceso.
- Cada persona solo puede editar su propia ficha: lo impone la base de datos.
