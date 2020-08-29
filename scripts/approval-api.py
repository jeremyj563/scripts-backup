import subprocess, os, sys
from flask import Flask
from flask_restful import Api, Resource, reqparse

working_path = os.path.dirname(os.path.realpath(__file__))

app = Flask(__name__)
api = Api(app)

def get_pending_approval():
  # get the value of the pending approval variable
  cmd = ["{0}/get_pending_approval.sh".format(working_path)]
  pending_approval = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
  return pending_approval

def set_pending_approval(status):
  # set the value of the pending approval variable
  cmd = ["{0}/set_pending_approval.sh".format(working_path), status]
  subprocess.call(cmd)

def invoke_backup():
  # start backup procedure (--dry-run=false)
  subprocess.Popen(["{0}/invoke_backup.sh".format(working_path), "false"])

class Approved(Resource):
  def get(self, approved):

    if approved == "true":
      is_pending_approval = get_pending_approval()
      if is_pending_approval == "true":
        set_pending_approval("false")
        invoke_backup()
        result = {"approved": "true"}
      else:
        result = {"pending_approval": "false"}
    elif approved == "false":
      set_pending_approval("true")
      result = {"approved": "false"}

    return result, 201

api.add_resource(Approved, "/<string:approved>")
app.run(debug=True, host='0.0.0.0', port=80)
