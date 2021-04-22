c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.notebook_dir = '/home/ou-user/MetadataTutorial-2'
c.NotebookApp.open_browser = False
c.NotebookApp.quit_button = False
c.JupyterHub.shutdown_on_logout
c.NotebookApp.iopub_data_rate_limit = 10000000
c.MappingKernelManager.cull_idle_timeout = 1200
c.MappingKernelManager.cull_interval = 10

c.NotebookApp.default_url = '/tutorial-server'



c.ServerProxy.servers = {
    'tutorial-server': {
        'command': [ 'python', '-m' 'tutorial_server', '--config=/etc/tutorial-server/production.ini', '--port={port}', '--basepath={base_url}tutorial-server/', ],
        'absolute_url': True,
    }
}
