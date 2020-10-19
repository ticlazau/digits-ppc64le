#!/usr/bin/env python2
# Copyright (c) 2016-2017, NVIDIA CORPORATION.  All rights reserved.

import os.path
import setuptools

LOCAL_DIR = os.path.dirname(os.path.abspath(__file__))

# Get current __version__
version_locals = {}
execfile(os.path.join(LOCAL_DIR, 'digits', 'version.py'), {}, version_locals)

setuptools.setup(
    name='digits',
    version=version_locals['__version__'],
    description="NVIDIA's Deep Learning GPU Training System",
    url='https://developer.nvidia.com/digits',
    author='DIGITS Development Team',
    author_email='digits@nvidia.com',
    license='BSD',
    classifiers=[
        'Framework :: Flask',
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 2 :: Only',
        'Topic :: Scientific/Engineering :: Artificial Intelligence',
    ],
    keywords='nvidia digits',
    packages=setuptools.find_packages(),
    include_package_data=True,
    zip_safe=False,
    scripts=['digits-devserver'],
)
