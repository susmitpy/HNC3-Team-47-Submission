from flask import Flask,request,jsonify


import json

from db import Interface



app=Flask(__name__)

inf = Interface()
inf.connect_db()

@app.route('/', methods=["GET"])
def api():
    return jsonify({"hi":"yay"})


@app.route('/register',methods=["POST"])
def register():
    det = request.form
    print("Details: ", det)
    print("Name: ", det.get("name"))
    inf.register(det.get("name"),det.get("phone"),det.get("passw"),det.get("uidai"))
    return jsonify({"res":"Succ"})

@app.route('/login',methods=["POST"])
def login():
    det = request.form
    print("Details: ", det)
    stored_pass = inf.login(det.get("phone"))
    if stored_pass == None:
        return jsonify({"res":"ne"})
    if det.get("pass") == stored_pass:
        return jsonify({"res":"Succ"})
    else:
        return jsonify({"res":"fail"})
    
@app.route('/suggestion',methods=["POST"])
def suggestion():
    det = request.form
    print("Details: ", det)
    new_points = inf.suggest(det.get("phone"),det.get("title"),det.get("idea"))
    print("Flask: ", new_points)
    return jsonify({"res":new_points})

# Single Use Plastic Used Report
@app.route('/supu',methods=["POST"])
def supu():
    det = request.form
    print("Details: ", det)
    new_points = inf.plastic_store(det.get("phone"),det.get("store_name"),det.get("addr"))
    print("Flask: ", new_points)
    return jsonify({"res":new_points})

# Inappropriate Dump Report
@app.route('/iadr',methods=["POST"])
def iadr():
    det = request.form
    print("Details: ", det)
    new_points = inf.dump(det.get("phone"),det.get("addr"))
    print("Flask: ", new_points)
    return jsonify({"res":new_points})

# Top 3 Users
@app.route('/leader',methods=["POST"])
def leader():
    top = inf.ret_leaderboard()
    print(top)  #[(23, 'asdasd'), (10, 'qwdasd'), (9, 'hebeb')]
    res = {}
    for i,j in top:
        res[i] = j
    return jsonify(res)
        

if __name__ == "__main__":
    app.run()