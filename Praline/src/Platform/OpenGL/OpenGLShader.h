#pragma once

#include "Praline/Renderer/Shader.h"
#include "Praline/Renderer/Buffer.h"

namespace Praline
{
	class OpenGLShader : public Shader
	{
	public:
		OpenGLShader(const std::string& vertexSource, const std::string& fragmentSource);
		virtual ~OpenGLShader() override;

		virtual void Bind() const override;
		virtual void Unbind() const override;

		virtual void UploadUniformMat3(const std::string& name, const glm::mat3& matrix);
		virtual void UploadUniformMat4(const std::string& name, const glm::mat4& matrix);

		virtual void UploadUniformInt(const std::string& name, int value);
		virtual void UploadUniformFloat(const std::string& name, float value);
		virtual void UploadUniformFloat2(const std::string& name, const glm::vec2& values);
		virtual void UploadUniformFloat3(const std::string& name, const glm::vec3& values);
		virtual void UploadUniformFloat4(const std::string& name, const glm::vec4& values);

	private:
		uint32_t m_RendererID;
	};
}

