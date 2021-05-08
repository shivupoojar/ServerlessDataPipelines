def handle(req):
    res = req.split()
 
# printing result
    json_file = {
                    "image": res[0],
                    "Predicted Time": res[3] + res[4],
                     "Detected objects": res[5:]
                  }

    return json_file



