#pragma once

#include <DGM/dgm.hpp>
#include <TGUI/TGUI.hpp>

class Log {
private:
	tgui::Gui *gui = nullptr;
	static Log *instance;

	Log() {}

public:
	static Log &get();

	void create(tgui::Theme& theme, const tgui::Layout2d& pos, const tgui::Layout2d& size);

	void toggle();

	static void write(const std::string& text);

	static void write(const std::string& label, const sf::Vector2i &vec);

	void init(tgui::Gui *gui) {
		Log::gui = gui;
	}
};