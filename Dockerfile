FROM docker.io/ibmcom/powerai:1.6.1-all-ubuntu18.04
MAINTAINER florin.manaila@de.ibm.com

ENV PATH /root/anaconda2/bin:$PATH

# Update packages, install some useful packages
RUN sudo apt-get update && sudo apt-get install git gcc vim -y && apt-get clean && rm -rf /var/cache/apt
WORKDIR /opt

# Install need packages
RUN sudo apt-get install --no-install-recommends git graphviz libfreetype6-dev python-dev python-flask python-flaskext.wtf python-gevent python-h5py python-numpy python-pil python-pip python-pkgconfig python-protobuf python-scipy python-setuptools python-magic -y
RUN sudo apt-get install libpcap-dev libpq-dev -y
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && pip install Flask Flask-WTF wtforms Flask-SocketIO setuptools
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && conda install -y gevent scikit-fmm wtforms Pillow numpy scipy protobuf six requests gevent gevent-websocket lmdb h5py pydot psutil matplotlib boto
RUN cd /opt && git clone https://github.com/NVIDIA/DIGITS.git
RUN rm -f /opt/DIGITS/setup.py
COPY setup.py /opt/DIGITS

RUN echo ". /root/anaconda2/etc/profile.d/conda.sh" >> ~/.bashrc && echo "conda activate base" >> ~/.bashrc
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && pip install -e /opt/DIGITS
# Install data plugins
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/sunnybrook && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/gan && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/imageGradients && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/textClassification && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/imageGradients && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/data/bAbI && pip install .
# Install visualization plugins
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/view/imageGradients && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/view/textClassification && pip install .
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && cd /opt/DIGITS/plugins/view/gan && pip install .
# Install python plugin
RUN . /root/anaconda2/etc/profile.d/conda.sh && conda activate base && pip install -e /opt/DIGITS

# Start DIGITS
EXPOSE 5000
CMD ["digits-devserver"]  

