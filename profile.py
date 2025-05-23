"""
UBUNTU22 + dataset 3DV

Instructions:

UBUNTU22 + dataset 3DV
"""

import geni.portal as portal
import geni.rspec.pg as pg
import geni.rspec.emulab as emulab

imageList = [
    ('urn:publicid:IDN+clemson.cloudlab.us+image+emulab-ops//UBUNTU22-64-ARM9', 'UBUNTU-ARM9'),
    ('urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU22-64-STD', 'UBUNTU-X64'),
]

ds_urn = "urn:publicid:IDN+clemson.cloudlab.us:wings-bangya-pg0+ltdataset+3D_vision"

pc = portal.Context()
pc.defineParameter("clientCount", "Number of NFS clients",
                   portal.ParameterType.INTEGER, 0)
pc.defineParameter("os_image", "OS image", portal.ParameterType.IMAGE, imageList[0], imageList)
pc.defineParameter("node_hw", "GPU node type", portal.ParameterType.NODETYPE, "nvidiags")
pc.defineParameter("data_size", "GPU node local storage size", portal.ParameterType.STRING, "1024GB")
pc.defineParameter("dataset", "Your dataset URN",
                   portal.ParameterType.STRING, ds_urn)
params = pc.bindParameters()
request = pc.makeRequestRSpec()

def build_new_node(name):
    ret = request.RawPC(name)
    ret.disk_image = params.os_image
    ret.hardware_type = params.node_hw
    bs = ret.Blockstore("bs-{}".format(name), "/local_data")
    bs.size = params.data_size
    return ret

# nfs lan
nfsLanName    = "nfsLan"
nfsLan = request.LAN(nfsLanName)
nfsLan.best_effort       = True
nfsLan.vlan_tagging      = True
nfsLan.link_multiplexing = True

nfsDirectory  = "/nfs"
nfsServer = build_new_node("node-0")

nfsLan.addInterface(nfsServer.addInterface())
nfsServer.addService(pg.Execute(shell="sh", command="sudo /bin/bash /local/repository/nfs-server.sh"))

# ds node
nfsDirectory  = "/nfs"
dsnode = request.RemoteBlockstore("dsnode", nfsDirectory)
dsnode.dataset = params.dataset

# links
dslink = request.Link("dslink")
dslink.addInterface(dsnode.interface)
dslink.addInterface(nfsServer.addInterface())
dslink.best_effort = True
dslink.vlan_tagging = True
dslink.link_multiplexing = True

# clients
for i in range(1, params.clientCount+1):
    node = build_new_node("node-%d" % i)
    nfsLan.addInterface(node.addInterface())
    node.addService(pg.Execute(shell="sh", command="sudo /bin/bash /local/repository/nfs-client.sh"))
    pass

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
