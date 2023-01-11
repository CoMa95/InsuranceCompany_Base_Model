import boto3 
import pandas as pd 
import os

class s3_connector:

    '''
    This class provides a direct way to load (read) or save (write) from and to an S3 bucket
    '''

    def __init__(self, up_folder = 'project1_data', down_folder = 'project1_data'):
        self.mybucket = 'insclaimsdata' 
        self.up_folder = up_folder
        self.down_folder = down_folder

    def read(self, file_name):
        data_location = f's3://{self.mybucket}/{self.down_folder}/{file_name}'
        return pd.read_feather(data_location)

    def write(self, file_name):
        boto3.Session().resource('s3').Bucket(self.mybucket).Object(os.path.join(self.up_folder, 
            file_name)).upload_file(file_name)
