#!/usr/bin/env python
# -*- coding: utf-8 -*-
# pylint: disable=line-too-long
from __future__ import absolute_import, division

import logging

from django.conf.urls import patterns, url

logger = logging.getLogger(__name__)  # pylint: disable=invalid-name

urlpatterns = patterns(  # pylint: disable=invalid-name
    '__module__.views',
#    url(r'^route$', 'the.view', name='the_name'),
    %HERE%
)

