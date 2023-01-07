FROM ubuntu:jammy-20221130
RUN apt-get update && apt install git -y
RUN apt-get update && \
    git clone https://github.com/yeshwanthlm/django-on-ec2.git && \
    apt install python3-pip -y && \
    pip install django 
RUN cd django-on-ec2 && \
    python3 manage.py makemigrations && \
    python3 manage.py migrate && \ 
    echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@myproject.com', 'password')" | python3 manage.py shell && \
    python3 manage.py runserver

