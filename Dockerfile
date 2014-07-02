# Base image
FROM ubuntu:14.04

# Maintainer information
MAINTAINER Michael Schultz

# Volume to connect
VOLUME ["/var/log"]

# Copy example app into the image
ADD myapp.sh /usr/bin/myapp

# Set executable flag for the script
RUN chmod +x /usr/bin/myapp

ENTRYPOINT ["/bin/bash"]

# Execute command, when starting the image
CMD ["-c", "/usr/bin/myapp"]


