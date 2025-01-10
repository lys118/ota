package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String imagePath = getServletContext().getRealPath("/views/auction/imgs" + pathInfo);
        File file = new File(imagePath);

        if (!file.exists()) {
            // 이미지가 없으면 기본 이미지를 보여줍니다.
            imagePath = getServletContext().getRealPath("/views/auction/imgs/default.jpg");
            file = new File(imagePath);
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }

        String contentType = getServletContext().getMimeType(imagePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        response.setContentType(contentType);
        response.setContentLength((int) file.length());

        Files.copy(file.toPath(), response.getOutputStream());
    }
}