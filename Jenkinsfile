pipeline {
    agent any

    environment {
        REPO_URL = 'http://github.com/svkrll/selenium-jenkins.git'
        ALLURE_RESULTS = 'allure-results'
    }

    parameters {
        string(name: 'SELENOID_URL', defaultValue: 'http://localhost:4444/wd/hub', description: 'Selenoid Executor URL')
        string(name: 'OPENCART_URL', defaultValue: 'http://localhost:8080', description: 'OpenCart App URL')
        choice(name: 'BROWSER', choices: ['chrome', 'firefox'], description: 'Browser')
        string(name: 'BROWSER_VERSION', defaultValue: '128.0', description: 'Browser Version')
        choice(name: 'THREADS', choices: ['1', '2', '4'], description: 'Number of Threads')
    }

    stages {
        stage('Checkout') {
            steps {
                    git url: "${REPO_URL}", branch: 'main'
                }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    apt update -y && apt install -y python3-pip python3-venv
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest tests/ \
                        --alluredir=${ALLURE_RESULTS} \
                        --browser ${BROWSER} \
                        --browser-version ${BROWSER_VERSION} \
                        --selenoid-url ${SELENOID_URL} \
                        --app-url ${OPENCART_URL}
                '''
            }
        }

        stage('Allure Report') {
            steps {
                allure includeProperties: false, jdk: '', results: [[path: "${ALLURE_RESULTS}"]]
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: "${ALLURE_RESULTS}/**", fingerprint: true
        }
    }
}

