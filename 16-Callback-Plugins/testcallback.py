from ansible.plugins.callback import CallbackBase

class CallbackModule(CallbackBase):

    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'stdout'
    CALLBACK_NAME = 'testcallback'

    def v2_playbook_on_start(self, playbook):
        self._display.display("Starte Playbook")

    def v2_playbook_on_play_start(self, play):
        self._display.display("Starte Play")

    def v2_playbook_on_task_start(self, task, is_conditional):
        self._display.display("Task: " + task.get_name())

    def v2_playbook_on_stats(self, stats):
        self._display.display("Fertig")

    def v2_runner_on_ok(self, result):
        self._display.display("OK: " + result._host.get_name())

    def v2_runner_on_skipped(self, result):
        self._display.display("SKIPPED: " + result._host.get_name())
