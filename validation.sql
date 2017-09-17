
CREATE TABLE `dashboard_activity_monitor` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `banner` longtext,
  `step` varchar(200) NOT NULL DEFAULT 'precheck',
  `hostname` varchar(200) NOT NULL,
  `os` varchar(200) NOT NULL,
  `ping_status` varchar(20) DEFAULT NULL,
  `ssh_status` varchar(20) DEFAULT NULL,
  `precheck` longtext,
  `postcheck` longtext,
  `ignored` tinyint(1) NOT NULL DEFAULT '0',
  `overall_status` tinyint(1) NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `dashboard_activity_monitor`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `dashboard_activity_monitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;
