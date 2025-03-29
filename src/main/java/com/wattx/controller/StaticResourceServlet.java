package com.wattx.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/resources/*")  // Maps to /resources/images/... URLs
public class StaticResourceServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getPathInfo();
        if (path == null || path.isEmpty() || path.equals("/")) {
            response.sendError(404, "Resource not specified");
            return;
        }

        // Security: Block path traversal attempts
        if (path.contains("..")) {
            response.sendError(403, "Forbidden path");
            return;
        }

        String fullPath = "/WEB-INF/resources" + path;
        InputStream is = getServletContext().getResourceAsStream(fullPath);

        if (is == null) {
            response.sendError(404, "Resource not found: " + path);
            return;
        }

        // Auto-detect MIME type (e.g. image/png)
        String mimeType = getServletContext().getMimeType(fullPath);
        response.setContentType(mimeType != null ? mimeType : "application/octet-stream");

        // Stream the file
        try (OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } finally {
            is.close();
        }
    }
}