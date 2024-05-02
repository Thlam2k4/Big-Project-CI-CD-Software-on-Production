pipeline{
    agent any
    environment{
        SONARSERVER = 'sonarserver'
        SONARSCANNER = 'sonarscanner'
        SONAR_SCANNER_HOME = tool name: 'sonarscanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        PATH = "${SONAR_SCANNER_HOME}/bin:${env.PATH}"
    }

    stages{
        stage('Git Checkouting and Pulling code'){
            steps{
                echo 'Pulling Code From Github'
               
                git branch: 'main', credentialsId: 'Software-prod-token', url: 'https://github.com/Thanhlam43k4/Big-Project-CI-CD-Software-on-Production.git'

                echo 'Pulling successfully'
            }
        }
        stage('Sonar Analysis'){
            steps{
                withEnv(["PATH+SONAR_SCANNER=${tool name: 'sonarscanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'}/bin"]) {
                withSonarQubeEnv('sonarserver') {
                      sh 'sonar-scanner \
                        -Dsonar.projectKey=jenkins-check-stage \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://192.168.56.105:9000 \
                        -Dsonar.login=sqp_0cd2459d203a734bfc169c0c11b85a444947aee4'
                    }
                }
            }
        }
        stage('Build Docker image and push to DockerHub'){
            steps{
                echo 'Build docker Image in file Dockerfile' //File Dockerfile in the dir of source code
                //Docker command
                sh 'docker build -t thanhlam2k4/loginapp:3.0 .' //In my case thanhlam2k4 is my dockerhub account you can change!!!
                //You can run docker image anh check your images in your local machine

                sh 'docker images'
                withDockerRegistry(credentialsId: 'dockerhub_id',url: 'https://index.docker.io/v1/') {
                    //Push to Dockerhub with dockerhub account thanhlam2k4
                    sh 'docker push thanhlam2k4/loginapp:3.0'
                }
            }            
        }
        stage('Deploy to Production in Kubernetes'){
            steps{
                script{
                    kubernetesDeploy (configs: 'mysql.yaml', kubeconfigId: 'kubernetes') //Deploy mysql-deploy on k8s with port 3306
                    kubernetesDeploy (configs: 'phpmyadmin.yaml', kubeconfigId: 'kubernetes') //Deploy phpmyadmin on k8s to handle the administration of MYSQL
                    kubernetesDeploy (configs: 'loginapp.yaml', kubeconfigId: 'kubernetes') // Deploy the application run on port 3000   
                }
            }
        }
         stage('Testing in Production'){
            steps{
                echo '>>>>>Testing in production enviroment<<<<'
                // sh 'ssh master.xtl@172.16.10.100'           //SSH to master node to review your pod and deployment
                // sh 'kubectl version'                        //check kubectl version
                // sh 'kubectl get pods -o wide'               //Check pod loginapp mysql phpmyadmin pod
                
            }
        }   
    }
}