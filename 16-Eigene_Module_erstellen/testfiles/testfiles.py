#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule
import os

def run_module():

    module_args = dict(
        path  =dict(type='path', required=False, default='/tmp'),
        number=dict(type='int',  required=False, default=10),
        format=dict(type='str',  required=True),
        state =dict(choices=['present', 'absent'], 
                    required=False,
                    default='present'
        )
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path  = module.params['path']
    state = module.params['state']


    if not os.path.isdir(path):  
        module.fail_json(msg=path + ' is not an existing directory')


    result = dict(changed=False)

    for i in range(1, module.params['number'] + 1):
        filepath = path + '/' + ( module.params['format'] % (i) )

        if state == 'present' and not os.path.exists(filepath):
            if not module.check_mode:
                os.mknod(filepath)
            result['changed'] = True

        if state == 'absent' and os.path.exists(filepath):
            if not module.check_mode:
                os.remove(filepath)
            result['changed'] = True

    module.exit_json(**result)


def main():
    run_module()

if __name__ == '__main__':
    main()
