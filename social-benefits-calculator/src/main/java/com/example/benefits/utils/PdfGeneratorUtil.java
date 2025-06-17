package com.example.benefits.utils;

import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;

import java.io.ByteArrayOutputStream;

public class PdfGeneratorUtil {
    public static ByteArrayOutputStream generatePdfFromHtml(String html) throws Exception {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        PdfRendererBuilder builder = new PdfRendererBuilder();
        builder.useFastMode();
        builder.withHtmlContent(html, null);
        builder.toStream(os);
        builder.run();
        return os;
    }
}
