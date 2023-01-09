from dotenv import load_dotenv
 
## using existing module to specify location of the .env file
from pathlib import Path
import os
 
load_dotenv()
env_path = Path('.')/'.env'
load_dotenv(dotenv_path=env_path)

class Config:
    # Database config info
    db_user = os.getenv('DATABASE_USERNAME')
    db_password = os.getenv('DATABASE_PASSWORD')
    db_host = os.getenv('DATABASE_HOST')
    db_port = os.getenv('DATABASE_PORT')
    db_name = os.getenv('DATABASE_NAME')