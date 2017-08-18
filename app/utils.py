import json
import socket
import logging

from django.http import JsonResponse
from django.shortcuts import HttpResponse, render
from QaBot.settings import QASNAKE_HOST, QASNAKE_PORT
from .models import *

logger = logging.getLogger("django")

# 业务逻辑层 Service
#   Aux functions for views.py
#
# 建议的命名，类RESTful思想：)
#   xxx_list    GET     查询概况列表
#   xxx_show    GET     查询单体详情
#   xxx_update  POST    创建/修改数据


########################
# Section A 数据库实体管理



#########################
# Section B 语法糖 Wrapper
def response_write(jsonData):
    # return JsonResponse(jsonData, json_dumps_params={'ensure_ascii': False})
    response = HttpResponse(json.dumps(jsonData, ensure_ascii=False))
    # response["Access-Control-Allow-Origin"] = "*"
    # response["Access-Control-Allow-Headers"] = "*"
    # response["Access-Control-Allow-Methods"] = "GET, POST, HEAD"
    # response["Access-Control-Max-Age"] = "1000"
    return response


def json_load(byteData):
    try:
        # logger.info('Raw GET/POST data: %s' % byteData)
        strData = isinstance(byteData, bytes) and byteData.decode('utf8') or byteData
        # logger.info('Try Decode using utf8: %s' % strData)
        jsonData = json.loads(strData, encoding='utf8', parse_int=int, parse_float=float)
        logger.info('Data to Json: %s' % jsonData)
        return jsonData
    except:
        return None


def qa_snake(kw):
    logger.info('[Quest] %s' % kw)
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((QASNAKE_HOST, QASNAKE_PORT))
    client.send(kw.encode('utf8'))
    ans = client.recv(4096).decode('utf8')
    logger.info('[Ans] %s...' % ans[:30])
    return ans

#########################
# Section C 错误码
def die(codeno):
    ERRMSG = {
        200: 'Done',
        400: 'Malformatted Request',
        401: 'Not Authorized',
        403: 'Missing Parameter, Duplicate Conflict or TypeError',
        404: 'Resource Not Found',
        500: 'Server Internal Error',
    }

    return {'errorno': codeno, 'errormsg': ERRMSG.get(codeno) or 'Unkown Error'}


#########################
# Section D 默认值配置
