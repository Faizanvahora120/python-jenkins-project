#!groovy

pipeline {
    agent any



    environment{
        SONARQUBE_TOKEN = credentials('sonartoken')
        scannerHome = tool 'sonarscanner'
          
    }


    stages {
        stage('GIT Clone') {
            steps {
      
                git branch: 'main', credentialsId: 'githublogin', url: 'https://github.com/Faizanvahora120/python-jenkins-project.git'
            }
        }

        // stage('Environment preparation') {
        //     steps {
        //         echo "-=- preparing project environment -=-"
        //         // Python dependencies
        //         sh "pip install -r **/requirements.txt"
        //     }
        // }
        stage('Compile') {
            steps {
                echo "-=- compiling project -=-"
                sh "python3 -m compileall ."
            }
        }

        // stage('Unit tests') {
        //     steps {
        //         echo "-=- execute unit tests -=-"
        //         sh "python3 -m unittest ."
        //     }
        // }

        // stage('Mutation tests') {
        //     steps {
        //         echo "-=- execute mutation tests -=-"
        //         // initialize mutation testing session
        //         sh "cosmic-ray init config.yml jenkins_session && cosmic-ray --verbose exec jenkins_session && cosmic-ray dump jenkins_session | cr-report"    
        //     }
        // }

        stage('Package') {
            steps {
                echo "-=- packaging project -=-"
                echo "No packaging phase for python projects ..."
            }
        }

        stage('Build Docker image') {
            steps {
                echo "-=- build Docker image -=-"
                sh "sudo docker build -t helloworld-jenkins-pipeline:${env.BUILD_NUMBER} ."
            }
        }

        stage('Run Docker image') {
            steps {
                echo "-=- run Docker image -=-"
                sh "sudo docker run --name helloworld-jenkins-pipeline:${env.BUILD_NUMBER} --d -p 5001:5000 helloword-container"
            }
        }

        // stage('Integration tests') {
        //     steps {
        //         echo "-=- execute integration tests -=-"
        //         sh "nosetests -v int_test"
        //     }
        // }

        // stage('Performance tests') {
        //     steps {
        //         echo "-=- execute performance tests -=-"
        //         sh "locust -f ./perf_test/locustfile.py --no-web -c 1000 -r 100 --run-time 1m -H http://172.18.0.3:5001"
        //     }
        // }

        // stage('Dependency vulnerability tests') {
        //     steps {
        //         echo "-=- run dependency vulnerability tests -=-"
        //         sh "safety check"
        //     }
        // }

        stage('Code inspection & quality gate') {
            steps {
                echo "-=- run code inspection & quality gate -=-"
                sh " ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=python-jenkins-project \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://3.145.199.65 \
                        -Dsonar.login=${SONARQUBE_TOKEN}"
            }
        }

        // stage('Push Docker image') {
        //     steps {
        //         echo "-=- push Docker image -=-"
        //         withDockerRegistry([ credentialsId: "werdar-wedartg-uiny67-adsuja0-12njkn3", url: "" ]) {
        //             sh "docker push restalion/python-jenkins-pipeline:0.1"
        //         }
                
        //         //sh "mvn docker:push"
        //     }
        // }
    }

    post {
        always {
            echo "-=- remove deployment -=-"
            sh "sudo docker stop python-jenkins-pipeline"
        }
    }
}