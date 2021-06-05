#!groovy


pipeline {
    agent {
        label 'myJenkins'
    }
    environment {
        TF_LOG_PATH = "./terraform.log"
        TF_LOG = "DEBUG"
		env.PATH = "${tool 'Terraform 0.12.10'}" + ":" +"$env.PATH"
	}
    stages {
        stage('Plan Using Terraform') {
            steps {
                script{
                    echo "Run Terraform Plan to test for errors"	
                    planEnvironment()
                    }
            }
        }
        stage('Deploy Using Terraform') {
            when {
                anyOf {
                    branch 'master'
                }
            }
            steps {
                script{
                    echo "Run Terraform Apply to execute code"
                    provisionEnvironment()
                }
            }
        }
    }
}


// functions

def planEnvironment() {
    echo "Terraform Planning:" 
 
    dir("terraform/dev") {
        sh ''' 
        terraform --version
        terraform init
        terraform plan
        
        '''
    }
}


def provisionEnvironment() {
    echo "Terraform Applying:" 
 
    dir("terraform/dev") {
        sh ''' 
        terraform apply -auto-approve
        
        '''
    }
}