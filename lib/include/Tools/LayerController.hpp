#pragma once

#include "include/Interfaces/CurrentLayerObserverInterface.hpp"

class LayerController final : public LayerObserverInterface
{
public: // LayerObserverInterface
	std::size_t getCurrentLayerId() const noexcept override;

	std::size_t getLayerCount() const noexcept override;

public:
	void moveUp();

	void moveDown();

private:
	std::size_t layerId = 0;
};