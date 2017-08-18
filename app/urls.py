from django.conf.urls import url
from . import views

# 控制层 Controller
#   函数名尽量与url对应，或者遵守一定的命名约定，只要便于管理即可
#   注意url从上到下的匹配顺序

urlpatterns = [
    url(r'^q', views.query),
    url(r'^log', views.log),

    url(r'^', views.index),
]
