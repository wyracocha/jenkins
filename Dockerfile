FROM jenkins/jenkins

# install jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENV JENKINS_USER ${JENKINS_USER}
ENV JENKINS_PASS ${JENKINS_PASS}
ENV PLUGINS_FORCE_UPGRADE true
ENV TRY_UPGRADE_IF_NO_MARKER true

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
COPY ./default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

# volume for Jenkins settings
VOLUME /var/jenkins_home
