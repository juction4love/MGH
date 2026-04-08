class NewsHeadline {
  final String source; // पत्रिकाको नाम (Onlinekhabar, Ratopati, etc.)
  final String title;  // मुख्य समाचार
  final String link;   // समाचारको लिङ्क
  final DateTime time;

  NewsHeadline({
    required this.source,
    required this.title,
    required this.link,
    required this.time,
  });
}
