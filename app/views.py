import os

from django.shortcuts import redirect, render
from django.views.decorators.csrf import csrf_exempt
from QaBot.settings import LOG_FILE
from .utils import *
# from .scheds import *

# 视图层 View
#   合理控制views.py和utils.py的胖瘦:)
#


@csrf_exempt
def query(request):
    if request.method == 'POST':
        data = json_load(request.body)
        if data and data.get('kw'):
            ans = qa_snake(data.get('kw'))
            return response_write({'ans': ans})


@csrf_exempt
def index(request):
    if request.method == 'POST':
        kw = request.POST.get('kw')
        if kw:
            ans = qa_snake(kw)
            return render(request, 'index.html', {'ans': ans})
    return render(request, 'index.html')


@csrf_exempt
def log(request):
    if request.GET.get("do") == 'clean':
        try:
            f = open(LOG_FILE, 'w+')
            f.write('===== [Log Cleaned] =====\n')
            f.close()
        except IOError as ioe:
            return HttpResponse('Failed')
        return redirect('/log')
    else:
        f = open(LOG_FILE)
        logs = [l for l in f.readlines()]
        logs = logs[:100]
        return render(request, 'log.html', {'logs': logs})
