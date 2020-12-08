#!/bin/sh

java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -noverify \
  -Xmx1G \
  -jar /home/tomes/runenv/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar \
  -configuration ./config_linux \
  -data $HOME/.cache/java_ls_workspace \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED

#  -configuration "$HOME/dev/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux" \
#  -data "$HOME/workspace" \
#  --add-modules=ALL-SYSTEM \
#  --add-opens java.base/java.util=ALL-UNNAMED \
#  --add-opens java.base/java.lang=ALL-UNNAMED
