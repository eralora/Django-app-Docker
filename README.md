# devopslab


1. Clone branch to your machine from repo
2. Generate key using this command "python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'"
3. Add generated key to ".env.dev" file + add host name
4. Configure Nginx for secure connection:
   - Make directory /etc/encryp
   - Create 2 files inside this dir /etc/encryp/nginx.key and /etc/encryp/nginx.crt
   - Run openssl command where -out file for key /etc/encryp/nginx.key and -out file for cert /etc/encryp/nginx.crt
4. Run this command in devopslab dir "docker-compose up -d --build"  
5. Then run this command "docker-compose exec web python manage.py migrate --noinput"
6. Check if everything is allright using browser(http://localhost) or curl

