import pathlib

from data_analysis.planner import DAPlannerAgent
from utu.agents import OrchestraAgent
from utu.config import ConfigLoader
from utu.ui.webui_chatbot import WebUIChatbot


def main():
    # Set up the agent
    config = ConfigLoader.load_agent_config("data_analysis", config_path="../../backend/configs/agents")
    config.planner_config["examples_path"] = pathlib.Path(__file__).parent / "data_analysis" / "planner_examples_data.json"
    config.reporter_config["template_path"] = pathlib.Path(__file__).parent / "data_analysis" / "web_reporter_sp.j2"
    runner = OrchestraAgent(config)
    planner = DAPlannerAgent(config)
    # await runner.build()
    runner.set_planner(planner)

    # Run the agent with a sample question
    # data from https://www.kaggle.com/datasets/joannanplkrk/its-raining-cats
    fn = str(pathlib.Path(__file__).parent / "data_analysis" / "test.xlsx")

    question = f"请分析位于`{fn}`的国内从业人员增减变动情况统计数据，查询出国内本年增加人数中，天津分公司的直接用工应届毕业生有多少人。"
    ui = WebUIChatbot(runner, example_query=question)

    ui.launch(port=config.frontend_port, ip=config.frontend_ip)


if __name__ == "__main__":
    main()
