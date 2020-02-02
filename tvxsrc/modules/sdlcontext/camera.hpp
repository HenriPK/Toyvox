
#pragma once

#include "extern.hpp"
#include "topics.hpp"

namespace tvx {
	class FreeCamera {
			glm::vec4 pos, rot, ctrl;
			double pitch = 0.0, yaw = 0.0, dt = 0.0, gridMode = 0.f, aspect = 1.f, sensitivity = 0.5, speed = 0.1;
			Subscription mouseMoveSub, mouseLeftSub, mouseRightSub, upDetSub, dnDetSub, gridSub;
			Subscription fwSub, bwSub, lfSub, rtSub, upSub, dnSub;
		public:
			explicit FreeCamera(
						const glm::vec3 &start = glm::vec3(),
						const std::string &fw = "w",
						const std::string &bw = "s",
						const std::string &lf = "a",
						const std::string &rt = "d",
						const std::string &up = "space",
						const std::string &dn = "c"
			);
			glm::vec4 getRot();
			glm::vec4 getPos();
			glm::vec4 getCtrl();
			void refresh(float delta);
			void setAspect(float wOverH);
	};
}