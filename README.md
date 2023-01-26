# devopslab


1. Clone branch to your machine from repo
2. Generate key using this command "python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'"
3. Add generated key to ".env.dev" file + add host name
4. Configure Nginx for secure connection:
   - Make directory in your project folder "mkdir ssl"
   - Create 2 files inside this dir "nginx.key" and "nginx.crt"
   - Run this command 'openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" \-newkey rsa:2048 -keyout ./ssl/nginx.key -out ./ssl/nginx.crt'
4. Run this command in devopslab dir "docker-compose up -d --build"  
5. Then run this command "docker-compose exec web python manage.py migrate --noinput"
6. Check if everything is allright using browser(http://localhost) or curl

