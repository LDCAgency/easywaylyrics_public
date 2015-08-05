from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from shared import response as sharedresponse
import json
import requests

HOST = 'http://<your-website>'
ENDPOINT_CONTACT = '/contato.php'

@csrf_exempt
def book_private_class(request):
    name = request.POST.get('name')
    email = request.POST.get('email')
    phone = request.POST.get('phone')
    ip = get_client_ip(request)

    payload = {'name': name, 'email': email, 'phone': phone, 'ip': ip}
    response = sharedresponse.BaseResponse(code=sharedresponse.HTTP_RESPONSE_OK)
    r = requests.post((HOST + ENDPOINT_CONTACT), data=payload)
    print r.text
    return HttpResponse(json.dumps(response.__dict__), content_type="application/json")


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip