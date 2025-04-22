package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class CSSServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String CSS_DIR = "/css/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the requested CSS file name from the URL
        String requestPath = request.getPathInfo();
        if (requestPath == null || requestPath.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "CSS file not specified");
            return;
        }

        // Construct the path to the CSS file
        String cssFilePath = CSS_DIR + requestPath;
        Path filePath = Paths.get(getServletContext().getRealPath("/") + cssFilePath);

        // Check if the file exists and is not a directory
        if (!Files.exists(filePath) || Files.isDirectory(filePath)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "CSS file not found");
            return;
        }

        // Set response headers
        response.setContentType("text/css");
        response.setHeader("Cache-Control", "max-age=3600"); // Optional: Cache for 1 hour

        // Stream the CSS file to the client
        try (InputStream inputStream = Files.newInputStream(filePath);
             OutputStream outputStream = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
}