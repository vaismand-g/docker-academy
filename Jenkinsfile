pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
		sudo docker build . -t damian/jenkins
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
		docker run -ti -p8000:8000 damian/jenkins
		wget 127.0.0.1:8000
		cat index.html
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
