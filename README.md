# django-docker


### やったこと
1. ディレクトリ作成  
2. DockerFile,docker-compose.ymlなど各ファイルを作成  
3. イメージビルド  
`docker-compose build`  
4. プロジェクト作成（アプリ名をconfigにした）  
`docker-compose run web django-admin startproject config .`  
5. マイグレーション、管理ユーザー作成  
`python manage.py migrate`  
`python manage.py createsuperuser`  


- - -


### config>settings.py　の修正
1. DATABASES > default
    ```
    'ENGINE': 'django.db.backends.mysql',
    'NAME': os.environ.get('MYSQL_DATABASE'),
    'USER': os.environ.get('MYSQL_USER'),
    'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
    'HOST': 'db',
    'PORT': '3306',
    ```

2. 認証関連
    ```
    LOGIN_URL = '/accounts/login'	#ログインしていない場合の遷移先URL
    LOGIN_REDIRECT_URL = '/'	 #ログイン後の遷移先URL
    LOGOUT_REDIRECT_URL = '/accounts/login'	 #ログアウト後の遷移先URL
    ```

3. ENV_STATEによる設定
    ```
    envstate = os.environ.get('ENV_STATE','local')
    if envstate=='production':
        DEBUG = False
        ALLOWED_HOSTS = []
    elif envstate=='staging':
        DEBUG = True
        ALLOWED_HOSTS = []
    else:
        DEBUG = True
        ALLOWED_HOSTS = [
            'localhost',
            'www.localhost',
        ]
    ```

- - -


### アプリ作成手順（appsにまとめる場合）
1. ディレクトリを作っておき下記コマンドで作成（例：application_name作成）  
`python manage.py startapp application_name apps/application_name`  
2. config > settings.py にアプリ追加  
`'apps.application_name.apps.ApplicationNameConfig',`  
3. config > urls.py にインクルード  
`path('application_name/', include('apps.application_name.urls')),`  
4. apps > application_name > apps.py アプリの名前変更  
`name = 'apps.application_name'`  
※`apps.`を先頭に追加  

